From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: kernel unaligned accesses on IA64 in IDE
Date: Thu, 21 Aug 2008 14:28:34 -0700
Message-ID: <20080821212834.GJ11729@us.ibm.com>
References: <20080819225606.GB22088@us.ibm.com> <87pro4v511.wl%peterc@chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:49203 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458AbYHUV2l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Aug 2008 17:28:41 -0400
Content-Disposition: inline
In-Reply-To: <87pro4v511.wl%peterc@chubb.wattle.id.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: tony.luck@intel.com, bzolnier@gmail.com, linux-ia64@vger.kernel.org, linux-ide@vger.kernel.org

On 20.08.2008 [11:39:22 +1000], Peter Chubb wrote:
> >>>>> "Nishanth" == Nishanth Aravamudan <nacc@us.ibm.com> writes:
> 
> Nishanth> Hi Tony, Bart, As mentioned in the cpu_clock() thread, I am
> Nishanth> seeing (consistently) 5 unaligned accesses in the bootlogs
> Nishanth> on a 2-node IA64 box:
> 
> First thing to do is to work out more precisely where the unaligned
> access is happening.  I suggest you recompile your kernel with debug
> info, and use GDB to find the actual line number of the unaligned access.

Sorry if this is not what you were asking for, but it seems like my
results are similar to Robin's, that outsl in ide_output_data() is the
problem?

[   32.602116] kernel unaligned access to 0xe000000644678466, ip=0xa0000001005174d1
[   32.609744] kernel unaligned access to 0xe00000064467846e, ip=0xa0000001005174d1
[   35.346388] kernel unaligned access to 0xe0000013041d693e, ip=0xa0000001005174d1
[   35.354016] kernel unaligned access to 0xe0000013041d6942, ip=0xa000000100517531
[   35.361633] kernel unaligned access to 0xe0000013041d6946, ip=0xa0000001005174d1

(gdb) l *0xa0000001005174d1
0xa0000001005174d1 is in ide_output_data (/usr/local/autobench/var/tmp/build/arch/ia64/include/asm/io.h:280).
275	__outsl (unsigned long port, const void *src, unsigned long count)
276	{
277		const unsigned int *sp = src;
278	
279		while (count--)
280			platform_outl(*sp++, port);
281	}
282	
283	/*
284	 * Unfortunately, some platforms are broken and do not follow the IA-64 architecture

(gdb) l *0xa000000100517531
0xa000000100517531 is in ide_output_data (/usr/local/autobench/var/tmp/build/arch/ia64/include/asm/io.h:280).
275	__outsl (unsigned long port, const void *src, unsigned long count)
276	{
277		const unsigned int *sp = src;
278	
279		while (count--)
280			platform_outl(*sp++, port);
281	}
282	
283	/*
284	 * Unfortunately, some platforms are broken and do not follow the IA-64 architecture

(gdb) disassemble 0xa0000001005174d1
Dump of assembler code for function ide_output_data:
...
0xa0000001005174d0 <ide_output_data+1040>:	[MMI]       ld8 r20=[r38]
0xa0000001005174d1 <ide_output_data+1041>:	            ld4 r45=[r37],4
0xa0000001005174d2 <ide_output_data+1042>:	            mov r46=r32
0xa0000001005174e0 <ide_output_data+1056>:	[MII]       nop.m 0x0
0xa0000001005174e1 <ide_output_data+1057>:	            adds r36=-1,r36;;
0xa0000001005174e2 <ide_output_data+1058>:	            nop.i 0x0
0xa0000001005174f0 <ide_output_data+1072>:	[MMI]       ld8 r21=[r20],8;;
0xa0000001005174f1 <ide_output_data+1073>:	            nop.m 0x0
0xa0000001005174f2 <ide_output_data+1074>:	            mov b6=r21
0xa000000100517500 <ide_output_data+1088>:	[MIB]       ld8 r1=[r20]
0xa000000100517501 <ide_output_data+1089>:	            nop.i 0x0
0xa000000100517502 <ide_output_data+1090>:	            br.call.sptk.many b0=b6;;
0xa000000100517510 <ide_output_data+1104>:	[MMI]       mov r46=r32
0xa000000100517511 <ide_output_data+1105>:	            nop.m 0x0
0xa000000100517512 <ide_output_data+1106>:	            cmp.eq p9,p8=-1,r36
0xa000000100517520 <ide_output_data+1120>:	[MMB]       mov r1=r42
0xa000000100517521 <ide_output_data+1121>:	            adds r36=-1,r36
0xa000000100517522 <ide_output_data+1122>:	      (p09) br.cond.dpnt.few 0xa0000001005171b0 <ide_output_data+240>
0xa000000100517530 <ide_output_data+1136>:	[MMI]       ld8 r20=[r38]
0xa000000100517531 <ide_output_data+1137>:	            ld4 r45=[r37],4
0xa000000100517532 <ide_output_data+1138>:	            nop.i 0x0;;
...

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
