From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC v3 01/13] libahci: Allow drivers to override start_engine
Date: Sun, 19 Jan 2014 19:48:29 +0100
Message-ID: <52DC1DFD.4060508@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com> <1390088935-7193-2-git-send-email-hdegoede@redhat.com> <20140119044643.GH3640@htj.dyndns.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBBF46CLAKGQEQOUIBXA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140119044643.GH3640-Gd/HAXX7CRxy/B6EtB590w@public.gmane.org>
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

On 01/19/2014 05:46 AM, Tejun Heo wrote:
> Hello, Hans.
>
> On Sun, Jan 19, 2014 at 12:48:43AM +0100, Hans de Goede wrote:
>>   void ahci_start_engine(struct ata_port *ap)
>>   {
>>   	void __iomem *port_mmio = ahci_port_base(ap);
>> +	struct ahci_host_priv *hpriv = ap->host->private_data;
>>   	u32 tmp;
>>
>> +	if (hpriv->start_engine) {
>> +		hpriv->start_engine(ap);
>> +		return;
>> +	}
>> +
>
> I'd much prefer if the driver always calls hpriv->start_engine() which
> is initialized to the default callback during common init and then
> overridden if necessary.

This is a bit trouble some because ahci_start_engine is also exported,
so the patch would also need to fix all callers (and probably un-export
it). I can do this in the next revision in the patch-set if you want me
to, just explaining why I choose to do this the way I did.

Regards,

Hans
