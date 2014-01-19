From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC v3 08/13] ahci-platform: Allow specifying
 platform_data through of_device_id
Date: Sun, 19 Jan 2014 19:56:53 +0100
Message-ID: <52DC1FF5.80101@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com> <1390088935-7193-9-git-send-email-hdegoede@redhat.com> <20140119113838.GE11123@htj.dyndns.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-sunxi+bncBDL4X2GMZUKRB7F76CLAKGQEAP3VGPI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140119113838.GE11123-Gd/HAXX7CRxy/B6EtB590w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hi,

On 01/19/2014 12:38 PM, Tejun Heo wrote:
> On Sun, Jan 19, 2014 at 12:48:50AM +0100, Hans de Goede wrote:
>> @@ -126,7 +151,7 @@ static void ahci_put_clks(struct ahci_host_priv *hpriv)
>>   static int ahci_probe(struct platform_device *pdev)
>>   {
>>   	struct device *dev = &pdev->dev;
>> -	struct ahci_platform_data *pdata = dev_get_platdata(dev);
>> +	const struct ahci_platform_data *pdata = ahci_get_pdata(dev);
>
> Let's please not add const.  For data types which are known to be
> terminal, const more or less works, I suppose but for anything even
> mildly complicated it ends up being more of a headache.  C just
> doesn't have enough language support to make const actually useful.
> e.g. now if somebody wants to add an accessor to ahci_platform_data()
> which is applicable to both readers and writers, we either need two
> separate accessors for const and !const paths or have to cast away
> const.

The problem is that:

1) of_match_device returns const, so without the const the code would need
to cast that const away somewhere
2) of_match_device is right to return const because
2a) the data can actually be const
2b) even if not const, it is shared between multiple instances of the same
device-type and thus should never be written too

So as Russell already said, the use of const is correct here, and the best
thing to do is to simply keep it.

Regards,

Hans
