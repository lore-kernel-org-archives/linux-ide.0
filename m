From: Tejun Heo <htejun@gmail.com>
Subject: Re: [stable] [PATCH] ata_piix: update map 10b for ich8m
Date: Tue, 07 Aug 2007 17:09:08 +0900
Message-ID: <46B828A4.9010306@gmail.com>
References: <20070806174327.GP13674@htj.dyndns.org> <20070807075336.GA13471@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:51590 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545AbXHGIJU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Aug 2007 04:09:20 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1339387rvb
        for <linux-ide@vger.kernel.org>; Tue, 07 Aug 2007 01:09:20 -0700 (PDT)
In-Reply-To: <20070807075336.GA13471@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, kristen.c.accardi@intel.com, stable@kernel.org

Greg KH wrote:
> On Tue, Aug 07, 2007 at 02:43:27AM +0900, Tejun Heo wrote:
>> Fix map entry 10b for ich8.  It's [P0 P2 IDE IDE] like ich6 / ich6m.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> Cc: <Kristen Carlson Accardi> kristen.c.accardi@intel.com
>> ---
>> Many users can be hit by this.  Please consider for -stable.  Thanks.
>>
>>  drivers/ata/ata_piix.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
>> index a78832e..c5b4509 100644
>> --- a/drivers/ata/ata_piix.c
>> +++ b/drivers/ata/ata_piix.c
>> @@ -436,7 +436,7 @@ static const struct piix_map_db ich8_map_db = {
>>  		/* PM   PS   SM   SS       MAP */
>>  		{  P0,  P2,  P1,  P3 }, /* 00b (hardwired when in AHCI) */
>>  		{  RV,  RV,  RV,  RV },
>> -		{  IDE,  IDE,  NA,  NA }, /* 10b (IDE mode) */
>> +		{  P0,  P2, IDE, IDE }, /* 10b (IDE mode) */
>>  		{  RV,  RV,  RV,  RV },
>>  	},
>>  };
> 
> Did this ever make it into Linus's tree?

Not yet.  Hmmm... Should I have mailed -stable separately after Jeff's ACK?

Thanks.

-- 
tejun
