From: "Christopher R. Thompson" <Christoffur050@Verizon.Net>
Subject: Re: ide-core.o & libata.o ICH5
Date: Wed, 22 Dec 2004 14:21:28 -0800
Message-ID: <41C9F368.1010000@Verizon.Net>
References: <41C341A4.9010401@Verizon.Net> <41C9D5AA.70804@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out008pub.verizon.net ([206.46.170.108]:11175 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S262066AbULVWV3
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Dec 2004 17:21:29 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Thanks. I'm getting the new kernel now.

Here's the ksymoops for the first one. (Kernel-002.log)
ksymoops -v vmlinux.Sharlie-fourteen -K -L -o /lib/modules/2.4.27/ -m 
System.map.Sharlie-fourteen <~/Sharlie-fourteen/Kernel-002.log
ksymoops 2.4.5 on i686 2.4.27-Sharlie-two.  Options used
     -v vmlinux.Sharlie-fourteen (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.27/ (specified)
     -m System.map.Sharlie-fourteen (specified)

No modules in ksyms, skipping objects
cpu: 0, clocks: 1999060, slice: 999530
kernel BUG at highmem.c:166!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0139aa8>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: f71b1078   ecx: 00000000   edx: f71b1570
esi: 00000000   edi: 00000000   ebp: c1c34000   esp: c1c35f68
ds: 0018   es: 0018   ss: 0018
Process keventd (pid: 2, stackpage=c1c35000)
Stack: f71b1078 fd85f9bb f71b1078 c1c35f84 c1c35f84 c011f04a f71b1078 
f71b15c4
       f71b15c4 c1c34560 c1c34570 c0127b53 c023a090 c1c35fb0 00000000 
c1c34560
       c1c34570 c1c34000 00000001 00000000 0000001b 00010000 00000000 
00000700
Call Trace:    [<fd85f9bb>] [<c011f04a>] [<c0127b53>] [<c0127a20>] 
[<c0105000>]
  [<c010733e>] [<c0127a20>]
Code: 0f 0b a6 00 b3 e8 21 c0 05 00 00 80 00 ba a0 ab 2a c0 c1 e8


 >>EIP; c0139aa8 <kunmap_high+8/70>   <=====

 >>ebx; f71b1078 <END_OF_CODE+36ed0ec0/????>
 >>edx; f71b1570 <END_OF_CODE+36ed13b8/????>
 >>ebp; c1c34000 <END_OF_CODE+1953e48/????>
 >>esp; c1c35f68 <END_OF_CODE+1955db0/????>

Trace; fd85f9bb <END_OF_CODE+3d57f803/????>
Trace; c011f04a <__run_task_queue+5a/70>
Trace; c0127b53 <context_thread+133/1c0>
Trace; c0127a20 <context_thread+0/1c0>
Trace; c0105000 <_stext+0/0>
Trace; c010733e <arch_kernel_thread+2e/40>
Trace; c0127a20 <context_thread+0/1c0>

Code;  c0139aa8 <kunmap_high+8/70>
00000000 <_EIP>:
Code;  c0139aa8 <kunmap_high+8/70>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0139aaa <kunmap_high+a/70>
   2:   a6                        cmpsb  %es:(%edi),%ds:(%esi)
Code;  c0139aab <kunmap_high+b/70>
   3:   00 b3 e8 21 c0 05         add    %dh,0x5c021e8(%ebx)
Code;  c0139ab1 <kunmap_high+11/70>
   9:   00 00                     add    %al,(%eax)
Code;  c0139ab3 <kunmap_high+13/70>
   b:   80 00 ba                  addb   $0xba,(%eax)
Code;  c0139ab6 <kunmap_high+16/70>
   e:   a0 ab 2a c0 c1            mov    0xc1c02aab,%al
Code;  c0139abb <kunmap_high+1b/70>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18>


Jeff Garzik wrote:

> You need (a) 2.4.29-pre2 and (b) to build IDE into the kernel, not as 
> a module.
>
> Also, when posting oopses, they are useless unless you run them 
> through ksymoops.
>
>     Jeff
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 

Christopher R. Thompson
Student of Mechanical Engineering
California State Polytechnic University, Pomona
home: http://www.csupomona.edu/~cthompson1/

Email: mailto:Christoffur050@Verizon.SPAM
Note the Anti-SSSpppaaammm Mailing address...
"Net" will work better than "SPAM" if
you really want to send a message to me.



