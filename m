From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/7] libata: implement ap->sata_spd_limit and helpers
Date: Sun, 02 Apr 2006 07:18:10 -0400
Message-ID: <442FB2F2.7050805@pobox.com>
References: <11439680862635-git-send-email-htejun@gmail.com> <442FAAB5.30501@pobox.com> <20060402110452.GJ13172@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:15232 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932332AbWDBLSP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 07:18:15 -0400
In-Reply-To: <20060402110452.GJ13172@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> On Sun, Apr 02, 2006 at 06:43:01AM -0400, Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> -	/* Issue phy wake/reset */
>>> +	/* SATA spec says nothing about how to reconfigure spd.
>>> +	 * Configuring before starting hardreset works for both of my
>>> +	 * test cases - ICH7 AHCI and sil3124.  Configuring while phy
>>> +	 * is off sounds nice but ICH7 chokes on that.  It preserves
>>> +	 * configured value but does not apply it.
>>> +	 */
>>> +	ata_set_sata_spd(ap);
>>> +
>>> +	/* issue phy wake/reset */
>>> 	scontrol = scr_read(ap, SCR_CONTROL);
>>> 	scontrol = (scontrol & 0x0f0) | 0x301;
>>> 	scr_write_flush(ap, SCR_CONTROL, scontrol);
>> This code is an example of configuring the phy while its off...  You put 
>> the speed setting before the phy wake.
>>
>> Everything else looks OK.
>>
> 
> This is embarrasing. :( I was being delusional.  I somehow thought

Well on the bright side the other 21 patches are OK :)


> DET=1 was PHY off and DET=0 was wake.  I'll test with actual PHY off
> (DET=2) and redo this patch.  Sorry about the confusion.

Well, whatever the results of testing, I don't want to deviate from 
scr_write([0x301 or 0x300]) being the first thing we do with the phy. 
That's what's tested and working in both Linux and Windows.  Don't be 
surprised at nutty hackery on Gen-1 controllers (PATA chips w/ SATA 
bridge), where deviating from the few tested SControl values and 
"programming situations" (chip states) can lead to trouble.

	Jeff


