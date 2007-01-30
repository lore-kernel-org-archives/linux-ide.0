From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: HPA and failed opcode was: 0x37 ?
Date: Tue, 30 Jan 2007 16:53:18 +0100
Message-ID: <45BF69EE.7050004@imc-berlin.de>
References: <45BF5003.3000503@imc-berlin.de> <45BF512D.4040500@imc-berlin.de> <311601c90701300744n294ecae7ia2dffeae55cfab1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:2937 "EHLO
	mail.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965239AbXA3PxU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jan 2007 10:53:20 -0500
In-Reply-To: <311601c90701300744n294ecae7ia2dffeae55cfab1c@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: linux-ide@vger.kernel.org

Eric,
 D. Mudama wrote:
> On 1/30/07, Steven Scholz <steven.scholz@imc-berlin.de> wrote:
>> > hda: Host Protected Area detected.
>> >         current capacity is 78140160 sectors (40007 MB)
>> >         native  capacity is 185074430006016 sectors (94758108163 MB)
>> > hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
>> > hda: task_no_data_intr: error=0x04 { DriveStatusError }
>> > ide: failed opcode was: 0x37
>> > hda: 78140160 sectors (40007 MB) w/8192KiB Cache, CHS=16383/255/63
> 
> 0x37 is READ NATIVE MAX ADDRESS EXT, which is the 48-bit version of
> the command to figure out how big the drive "really" is.  It appears
> that model of drive indicated support for 48-bit commands, but then
> aborted the 48-bit version of READ NATIVE MAX ADDRESS.
> 
> Is it really a 40GB drive?

Well. It's a pretty new Seagate ST940813AM  (2.5") with "40GB" printed on it.

Steven


