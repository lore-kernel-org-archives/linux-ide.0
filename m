From: "Janos Haar" <janos.haar@netcenter.hu>
Subject: Re: possible data corruption on ICH8 or WD raptor
Date: Fri, 1 Aug 2008 12:40:04 +0200
Message-ID: <037e01c8f3c2$f81c5330$0400a8c0@dcccs>
References: <0b8b01c8e5fb$65ed9480$0400a8c0@dcccs> <48929113.4020402@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-2";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.netcenter.hu ([195.228.254.57]:40845 "EHLO netcenter.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752906AbYHAK61 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Aug 2008 06:58:27 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org


----- Original Message ----- 
From: "Tejun Heo" <tj@kernel.org>
To: "Janos Haar" <djani22@netcenter.hu>
Cc: <linux-ide@vger.kernel.org>
Sent: Friday, August 01, 2008 6:29 AM
Subject: Re: possible data corruption on ICH8 or WD raptor


> Janos Haar wrote:
>> Hello list,
>>
>> I have one (planned) production ready server with DP35DP Intel
>> motherboard, and 6 drive.
>>
>> 2x 500GB WD SATA (not interesting)
>> 4x 300GB WD Velociraptor, SATA2
>>
>> When i have tested the server i see one error report on the dmesg:
>>
>> ata3.00: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xa frozen
>> ata3.00: irq_stat 0x00400040, connection status changed
>> ata3: SError: { PHYRdyChg DevExch }
>> ata3.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
>>         res 40/00:20:40:de:90/00:00:07:00:00/40 Emask 0x10 (ATA bus 
>> error)
>
> You're getting PHY event on flush which is a pretty strong indication
> that you're having power problem.  The disk goes out to transfer data in
> its buffer to the platter and draws more power from the cable.  For some
> reason, power is not maintained properly.  Disk checks out momentarily
> causing the PHY event and losing the data in its buffer.  Try to connect
> the harddrive to a separate PSU and see whether the problem goes away.

Hello,

Thank you for the answer.

Now, this server is a productive syetem, and runs an important application.
The problem generally exists, but looks like comes only when i am testing 
the transfer with big files.
(the application does not do that)

About the power:
This PC have one 650W Chieftech PS, 1 quad core cpu, and 6 hdd.
I have previously measured the power current on the line, and the PC uses 
only 100-120W on peak.

The problem only comes on the 4 raptor hdd, and this drive only uses each 
6W. (from the documentation).

It is hard to try separate PS or something hw solution.
Additionally, generally i think it is not power issue, i am 90% sure.

Are you sure this can not be software issue?
If you say yes, i will go into the server room, and will try another ps 
anyway....

more info:
The PC have 8GB ram, and memtest runs previously 4 day continously, without 
error.

Thanks,
Janos Haar

>
> -- 
> tejun
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html 

