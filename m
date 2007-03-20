From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Tue, 20 Mar 2007 15:27:35 +0800
Message-ID: <45FF8CE7.4040905@tw.ibm.com>
References: <45F873AC.6010204@gmail.com> <200703172107.42107.bzolnier@gmail.com> <45FD0F68.7090207@gmail.com> <200703181610.33714.bzolnier@gmail.com> <45FE7DCC.3000507@ru.mvista.com> <45FEE5EB.9020909@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:34512 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335AbXCTH1s (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Mar 2007 03:27:48 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2K7RlK8003600
	for <linux-ide@vger.kernel.org>; Tue, 20 Mar 2007 03:27:47 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2K7Rl6u064378
	for <linux-ide@vger.kernel.org>; Tue, 20 Mar 2007 01:27:47 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2K7RlmV010471
	for <linux-ide@vger.kernel.org>; Tue, 20 Mar 2007 01:27:47 -0600
In-Reply-To: <45FEE5EB.9020909@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: YUP <yupadmin@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, albertl@mail.com, linux-ide@vger.kernel.org

YUP wrote:
> Hi Sergei, Albert and Bartek,
> 
> Thanks for the patch. If you dealt with it, could you please apply this
> patch to 2.6.20.3 kernel and send me diff? I'm just afraid that I
> couldn't do it right.
> 
> Albert and Bartek,
> 
> please find latest dmsg output with Albert's patch. I quoted here only
> output after the first "qc timeout" as Albert requested (see below).
> Hope it will help you.
> 

Thanks for the help. Your trace is valuable.
It seems we have identified the cause.

The AOpen drive returned 0x51 (check condition) on INQUIRY of 254 bytes,
and it seems to mess up when REQUEST SENSE was issued:

[  105.480046] CDB (4:0,1,0) 12 01 00 00 fe 00 00 00 00
[  105.480101] ata4: protocol 5 task_state 4 (dev_stat 0x58) <== INQUIRY
[  105.480551] ata4: protocol 5 task_state 1
[  105.480555] ata4: host_stat 0x4
[  105.480561] ata4: protocol 5 task_state 1 (dev_stat 0x51)
[  105.480564] ata4: protocol 5 task_state 2 (dev_stat 0x51)
[  105.480567] ata4: protocol 5 task_state 3 (dev_stat 0x51) <= check condition
[  105.480644] ata4: protocol 5 task_state 4 (dev_stat 0x58)  <== REQUEST SENSE
[  113.509692] ata4: protocol 5 task_state 1 <== interrupt. device BSY.
[  113.509703] ata4: host_stat 0x0           <== device messed up
[  113.510276] ata4: protocol 5 task_state 1
[  113.510280] ata4: host_stat 0x0
[  113.510890] ata4: protocol 5 task_state 1
[  113.510894] ata4: host_stat 0x0
[  113.512120] ata4: protocol 5 task_state 1 <== .. loop until time out

This INQUIRY problem can be reliable reproduced:

[  171.258863] CDB (4:0,1,0) 12 01 00 00 fe 00 00 00 00
[  171.258918] ata4: protocol 5 task_state 4 (dev_stat 0x58) <== INQUIRY
[  171.259359] ata4: protocol 5 task_state 1
[  171.259363] ata4: host_stat 0x4
[  171.259368] ata4: protocol 5 task_state 1 (dev_stat 0x51)
[  171.259371] ata4: protocol 5 task_state 2 (dev_stat 0x51)
[  171.259374] ata4: protocol 5 task_state 3 (dev_stat 0x51)<= check condition
[  171.259451] ata4: protocol 5 task_state 4 (dev_stat 0x58) <== REQUEST SENSE
[  172.538040] ata4: protocol 5 task_state 1 <== interrupt. device BSY.
[  172.538051] ata4: host_stat 0x0           <== device messed up
[  172.538145] ata4: protocol 5 task_state 1
[  172.538150] ata4: host_stat 0x0
[  173.424869] ata4: protocol 5 task_state 1 <== .. loop until time out

Except INQUIRY, other commands/REQUEST SENSE are ok.
(ex. TEST UNIT READY)
[  105.456944] CDB (4:0,1,0) 00 00 00 00 00 00 00 00 00
[  105.457003] ata4: protocol 6 task_state 4 (dev_stat 0x58) <= TEST UNIT READY
[  105.457551] ata4: protocol 6 task_state 2
[  105.457555] ata4: host_stat 0x4
[  105.457561] ata4: protocol 6 task_state 2 (dev_stat 0x51)
[  105.457563] ata4: protocol 6 task_state 3 (dev_stat 0x51)<= check condition
[  105.457647] ata4: protocol 5 task_state 4 (dev_stat 0x58) <== REQUEST SENSE
[  105.458233] ata4: protocol 5 task_state 1 <== interrupt. device ok.
[  105.458237] ata4: host_stat 0x4           
[  105.458242] ata4: protocol 5 task_state 1 (dev_stat 0x58)
[  105.458350] ata4: protocol 5 task_state 1
[  105.458353] ata4: host_stat 0x4           <== device returns sense data ok.
[  105.458358] ata4: protocol 5 task_state 1 (dev_stat 0x50)
[  105.458361] ata4: protocol 5 task_state 2 (dev_stat 0x50)

Hi Yarema,

Could you help to send me the dmesg before the first qc timeout (i.e. before 
[   69.646046] ata4.01: qc timeout (cmd 0xa0)).

We can see how the AOpen drive deal with the first INQUIRY (e.g. 36 bytes).
Thanks.
--
albert

