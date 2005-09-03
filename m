From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.13] libata: Marvell SATA support (PIO mode)
Date: Sat, 03 Sep 2005 13:29:30 -0400
Message-ID: <4319DD7A.7000702@pobox.com>
References: <20050830183625.BEE1520F4C@lns1058.lss.emc.com> <4314C604.4030208@pobox.com> <20050901142754.B93BF27137@lns1058.lss.emc.com> <4319AE7B.3010304@dtbb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751140AbVICR35@vger.kernel.org>
In-Reply-To: <4319AE7B.3010304@dtbb.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Tyler <pml@dtbb.net>
Cc: Brett Russ <russb@emc.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Tyler wrote:
> Brett Russ wrote:
> 
>> Some (non-functional) cleanup modifications since the version 0.10
>> driver I sent out 2005-08-30.  Also adding signed-off-by for Jeff's
>> upstream push.  This is my libata compatible low level driver for
>> the Marvell SATA family.  Currently it successfully runs in PIO mode
>> on a 6081 chip.  EDMA support is in the works and should be done
>> shortly.  Review, testing (especially on other flavors of Marvell),
>> comments welcome.
>>
>> Thank you,
>> BR
>>
>> Signed-off-by: Brett Russ <russb@emc.com>
>>
>>  
>>
> [snip..]
> 
> Please find attached patches that add the Adaptec 1420SA controller to 
> the PCI ID list in the driver, and a small note in the kernel config 
> option to state so.  This is untested as of currently, if anyone has a 
> 1420SA to try, that would be great..  The one I had access to is now 
> gone to a remote location out of reach for testing.  I read in one post 
> I found with google, that the 1420SA uses a 6541 chip instead of a 6041, 
> but I am not able to verify this, and also don't know if it may still 
> work as a 6041.  The card is still a Sata2, PCI-X card, with 4 ports, 
> the same as the 6041 based cards.  This patch may or may not be 
> useful..  The card comes with a manufacturer ID of 9005 according to a 
> linux PCI-ID list, which is a secondary id of Adaptec's known as 
> ADAPTEC2, and an actual PCI Id of 0241.

I would prefer to have it tested, before accepting this patch...

	Jeff
