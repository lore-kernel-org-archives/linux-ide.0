From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: [PATCH 2.6.22-rc5] libata: add HTS541616J9SA00 to NCQ blacklist
Date: Sun, 24 Jun 2007 20:47:46 -0700
Message-ID: <467F3AE2.7010606@vc.cvut.cz>
References: <fa.sspu6LOivd/touNtS2IsMKPqHa0@ifi.uio.no> <fa.19XJG1Asdp1zwcWLxolIH6F+5lY@ifi.uio.no> <467EC909.9040006@shaw.ca> <467F2495.3080509@gmail.com> <467F286B.40607@gmail.com> <467F2ADF.1040600@shaw.ca> <467F2D53.2000202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailgw.cvut.cz ([147.32.3.235]:48192 "EHLO mailgw.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812AbXFYEQV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Jun 2007 00:16:21 -0400
In-Reply-To: <467F2D53.2000202@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Robert Hancock <hancockr@shaw.ca>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, enricoss@tiscali.it, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Robert Hancock wrote:
>> Tejun Heo wrote:
>>> Another member of HTS5416* family doing spurious NCQ completion.
>>>
>>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>> Cc: Enrico Sardi <enricoss@tiscali.it>
>>> ---
>>>  drivers/ata/libata-core.c |    1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>> index adfae9d..fbca8d8 100644
>>> --- a/drivers/ata/libata-core.c
>>> +++ b/drivers/ata/libata-core.c
>>> @@ -3803,6 +3803,7 @@ static const struct ata_blacklist_entry
>>> ata_device_blacklist [] = {
>>>      /* Drives which do spurious command completion */
>>>      { "HTS541680J9SA00",    "SB2IC7EP",    ATA_HORKAGE_NONCQ, },
>>>      { "HTS541612J9SA00",    "SBDIC7JP",    ATA_HORKAGE_NONCQ, },
>>> +    { "Hitachi HTS541616J9SA00", "SB4OC70P", ATA_HORKAGE_NONCQ, },
>>>      { "WDC WD740ADFD-00NLR1", NULL,        ATA_HORKAGE_NONCQ, },
>>>  
>>>      /* Devices with NCQ limits */
>>>
>> Is that the right ID string? Strange that that one has Hitachi at the
>> front and the others don't..
> 
> Yeah, I realized that and asked Enrico about it.  :-)

I think that "new" one is correct, while old ones are incorrect (unless 
it uses strstr()) - all my Hitachis claim to be Hitachis - like this one 
(which seems to work fine with NCQ):

gwy:~# hdparm -i /dev/sda

/dev/sda:

  Model=Hitachi HDT725032VLA380                 , FwRev=V54OA52A, 
SerialNo=      VFA200R208LH5J
  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }

								Petr

