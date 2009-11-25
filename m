From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 62/86] pata_pdc202xx_old: document known issues
Date: Wed, 25 Nov 2009 12:50:26 -0500
Message-ID: <4B0D6E62.3010609@garzik.org>
References: <20091125170218.5446.13513.sendpatchset@localhost>	<20091125170948.5446.32754.sendpatchset@localhost> <20091125174632.174666be@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934793AbZKYRuc@vger.kernel.org>
In-Reply-To: <20091125174632.174666be@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 11/25/2009 12:46 PM, Alan Cox wrote:
> On Wed, 25 Nov 2009 18:09:48 +0100
> Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>  wrote:
>
>> From: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
>> Subject: [PATCH] pata_pdc202xx_old: document known issues
>>
>> Document known issues with the driver to aid distribution makers,
>> users and developers in making informed decisions instead of wasting
>> their time needlessly.
>>
>> Signed-off-by: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
>> ---
>>   drivers/ata/Kconfig |    4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> Index: b/drivers/ata/Kconfig
>> ===================================================================
>> --- a/drivers/ata/Kconfig
>> +++ b/drivers/ata/Kconfig
>> @@ -583,6 +583,10 @@ config PATA_PDC_OLD
>>   	  This option enables support for the Promise 20246, 20262, 20263,
>>   	  20265 and 20267 adapters.
>>
>> +	  Known issues:
>> +	  - UDMA transfers fail mysteriously on some chipsets
>> +	  - ATAPI DMA is unsupported currently
>
> Not sure this is useful, because the reports of UDMA failures are lower
> than most other reports. Should IPV6 have "known issues, mysterious timer
> list corruption" for example which occurs far more. Not do we list 'no
> atapi dma' in the help for the IDE SII driver ?

If the chip can support ATAPI DMI, but the driver does not, that 
deserves a comment, even if it's "hardware bugs prevent ATAPI DMA" or 
"ATAPI DMA would require much more code to support, so we did not bother 
for now"

Ditto for things like useful ideas ("consider PIO-over-DMA in SiI 311x") 
and other would-be-nice-to-have ideas.  These can serve as projects for 
newbies, or reminders for old-timers.

Space in the driver source code comment header is cheap.  Use liberally 
:)  Write a Shakespearean soliloquy on a chip's hardware bugs, if you'd 
like.

	Jeff
