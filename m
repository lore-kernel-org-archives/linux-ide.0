From: Tejun Heo <htejun@gmail.com>
Subject: Re: FW: LIBATA issue with SATA drive
Date: Tue, 23 Oct 2007 11:58:22 +0900
Message-ID: <471D634E.9080300@gmail.com>
References: <AF1760336DB49F43983B755855C2A46702AF744B@troe2k1.cs.myharris.net>	 <4716DC7D.6050007@gmail.com>	 <64bb37e0710181152j7d070258w9b9eeb59cf1f0a1d@mail.gmail.com>	 <471804CA.9040103@gmail.com>	 <64bb37e0710182151j6992cde3u4f9ae60aa70e22eb@mail.gmail.com>	 <47183B31.4080002@gmail.com> <64bb37e0710190921w66efe89dl1136d08328123629@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:34469 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbXJWC6b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Oct 2007 22:58:31 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1369547rvb
        for <linux-ide@vger.kernel.org>; Mon, 22 Oct 2007 19:58:31 -0700 (PDT)
In-Reply-To: <64bb37e0710190921w66efe89dl1136d08328123629@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Torsten Kaiser <just.for.lkml@googlemail.com>
Cc: linux-ide@vger.kernel.org

Torsten Kaiser wrote:
> On 10/19/07, Tejun Heo <htejun@gmail.com> wrote:
>> Torsten Kaiser wrote:
>>> Just remebered another thing about sata_sil24 that popped up with 2.6.23-mm1.
>>> With this kernel version (comparing to 2.6.23-rc8-mm1) the port
>>> probing time goes up from ~0.5 seconds per port/drive to ~2 seconds.
>>> Also the SControl changed:
>>>
>>> 2.6.23-rc8-mm1:
>>> [    4.110000] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>>> 2.6.23-mm1:
>>> [    5.930000] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
>>>
>>> But except for increased delay during boot no errors can seen, the
>>> drives work normally.
>> Yeah, PARTIAL / SLUMBER mode restriction is lifted.  Dunno whether
>> that's related to the increased delay tho.  Will investigate.
> 
> But don't invest too much time into this.
> That the delay is part of the broken ACPI of this board/bios seems
> very likely to me.
> (And apart from that delay there seems to be no other changes.)

Alright, found it.  Its because sata_sil24 now uses hardreset during
probing.  This behavior has changed because sil24 now supports PMP and
some PMPs don't work with only SRST.  HRST uses longer timing values to
make sure PHY gets stable before proceeding and that's where the extra
wait is coming from.

Thanks.

-- 
tejun
