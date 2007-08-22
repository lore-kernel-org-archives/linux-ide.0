From: "chia" <liuc@ceat.okstate.edu>
Subject: Re:
Date: Tue, 21 Aug 2007 23:18:51 -0500
Message-ID: <006101c7e473$8b924760$a378c00a@chia>
References: <114377ad0708211840i638c4cb4v4187caab39868a12@mail.gmail.com> <46CBA353.7090108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.ceat.okstate.edu ([139.78.73.125]:1127 "EHLO
	mail.ceat.okstate.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbXHVE0Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Aug 2007 00:26:24 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Dear Tejun, Is 10.3 beta stable? Do I still need to patch it? If I do, what 
version I should use? Can I apply a higher version patch to lower version of 
kernel? Thanks!
--------------------------------------------------------------
Chia-Ming Liu, Ph.D.
Mixed Signal VLSI Design Group
Advanced Technology Research Center 235
Oklahoma State University

Website: http://msvlsi.okstate.edu
US Mail: 202 Engineering South Stillwater, OK 74078
Phone: 405-744-1662, 405-744-6241
Fax: 405-744-9198
----- Original Message ----- 
From: "Tejun Heo" <htejun@gmail.com>
To: "chia-ming liu" <chiaming.liu@gmail.com>
Cc: <linux-ide@vger.kernel.org>; <liuc@okstate.edu>
Sent: Tuesday, August 21, 2007 9:45 PM
Subject: Re:


> chia-ming liu wrote:
>> Dear Tejun, I am not very good at linux and just enough to get by. I
>> have tried to use your patch by issuing the command 'patch -p1 <
>> combined.patch' and I receive this
>>
>> msvlsi63:~/libata-tj-2.6.18.1-20061020 # patch -p1 < combined.patch
>> can't find file to patch at input line 5
>> Perhaps you used the wrong -p or --strip option?
>> The text leading up to this was:
>> --------------------------
>> |Index: work/drivers/scsi/Kconfig
>> |===================================================================
>> |--- work.orig/drivers/scsi/Kconfig     2006-10-20 10:48:25.000000000 
>> +0900
>> |+++ work/drivers/scsi/Kconfig  2006-10-20 10:48:35.000000000 +0900
>> --------------------------
>> File to patch:
>>
>> Then, I opened combined.path and look for line 5
>>
>>  source "drivers/scsi/megaraid/Kconfig.megaraid"
>>
>> which point out the file I don't have. Am I missing something? I have
>> Opensuse 10.2 and Norco DS-1220 disk array which has Silicon Image
>> 3726 port multiplier.
>>
>> I don't have any driver install but Suse has recognized the PCI card
>> with Silicon Image 3124.
>
> OpenSUSE 10.3 Beta contains PMP support.  I think that will be easier.
>
> -- 
> tejun
> 


