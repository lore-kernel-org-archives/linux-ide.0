From: Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 03/10] ata: ahci_brcmstb: add support 40nm platforms
Date: Sat, 24 Oct 2015 13:50:54 +0900
Message-ID: <DE776F55-6D75-4AD7-B3AA-52E45C9D99C0@gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com> <1445564663-66824-4-git-send-email-jaedon.shin@gmail.com> <20151023212558.GS13239@google.com>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151023212558.GS13239-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux MIPS Mailing List <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hi Brian,

On Oct 24, 2015, at 6:25 AM, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 
> Hi Jadeon,
> 
> Hmm, my suspicions about the PHY driver are probably meant to be applied
> here. I don't think this change is sufficient.
> 
> On Fri, Oct 23, 2015 at 10:44:16AM +0900, Jaedon Shin wrote:
>> Add offsets for 40nm BMIPS based set-top box platforms.
>> 
>> Signed-off-by: Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>> drivers/ata/ahci_brcmstb.c | 11 +++++++++--
>> 1 file changed, 9 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
>> index 8cf6f7d4798f..59eb526cf4f6 100644
>> --- a/drivers/ata/ahci_brcmstb.c
>> +++ b/drivers/ata/ahci_brcmstb.c
>> @@ -50,7 +50,8 @@
>>   #define SATA_TOP_CTRL_2_SW_RST_RX			BIT(2)
>>   #define SATA_TOP_CTRL_2_SW_RST_TX			BIT(3)
>>   #define SATA_TOP_CTRL_2_PHY_GLOBAL_RESET		BIT(14)
>> - #define SATA_TOP_CTRL_PHY_OFFS				0x8
>> + #define SATA_TOP_CTRL_28NM_PHY_OFFS			0x8
>> + #define SATA_TOP_CTRL_40NM_PHY_OFFS			0x4
> 
> I don't remember the exact 40nm vs. 28nm map that well, but judging by
> the code-is-the-documentation, the 28nm layout is like this:
> 
> base + 0x0C = port 0, phy control 1
> base + 0x10 = port 0, phy control 2
> base + 0x14 = port 1, phy control 1
> base + 0x18 = port 1, phy control 2
> 
> but the 40nm layout is differnt, where the ports are interleaved:
> 
> base + 0x0C = port 0, phy control 1
> base + 0x10 = port 1, phy control 1
> base + 0x14 = port 0, phy control 2
> base + 0x18 = port 1, phy control 2
> 
> So, your patch gets phy control 1 correct for both ports, but it doesn't
> get phy control 2 correct. (Or at least, even if my guess at the 40nm
> layout is wrong, your patch makes "port 0, phy control 2" collide with
> "port 1, phy control 1", which is most certainly a bug.)
> 
> Are you sure you're testing this properly? Did you try using both ports
> at the same time? And please, apply the same scrutiny to the PHY driver.
> (e.g., did you test SSC? did you test both ports?)
> 
> Brian
> 

You are right. This must be changed. 

I found the 28nm chipsets have four phy interface control registers. But, 
the the 40nm chipsets have only three registers. I did not testing with 
two ports at the same time. It seems we should check more.

Thanks.

Jaedon

>>  #define SATA_TOP_MAX_PHYS				2
>> #define SATA_TOP_CTRL_SATA_TP_OUT			0x1c
>> #define SATA_TOP_CTRL_CLIENT_INIT_CTRL			0x20
>> @@ -237,7 +238,13 @@ static int brcm_ahci_resume(struct device *dev)
>> 
>> static const struct of_device_id ahci_of_match[] = {
>> 	{.compatible = "brcm,bcm7445-ahci",
>> -			.data = (void *)SATA_TOP_CTRL_PHY_OFFS},
>> +			.data = (void *)SATA_TOP_CTRL_28NM_PHY_OFFS},
>> +	{.compatible = "brcm,bcm7346-ahci",
>> +			.data = (void *)SATA_TOP_CTRL_40NM_PHY_OFFS},
>> +	{.compatible = "brcm,bcm7360-ahci",
>> +			.data = (void *)SATA_TOP_CTRL_40NM_PHY_OFFS},
>> +	{.compatible = "brcm,bcm7362-ahci",
>> +			.data = (void *)SATA_TOP_CTRL_40NM_PHY_OFFS},
>> 	{},
>> };
>> MODULE_DEVICE_TABLE(of, ahci_of_match);
>> -- 
>> 2.6.2
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
