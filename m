From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC v3 03/13] ahci-platform: Fix clk
 enable/disable unbalance on suspend/resume
Date: Sun, 19 Jan 2014 20:52:21 +0100
Message-ID: <52DC2CF5.5080109@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com> <1390088935-7193-4-git-send-email-hdegoede@redhat.com> <20140119111412.GA11123@htj.dyndns.org> <52DC1DAA.3010403@redhat.com> <20140119191554.GB32165@mtj.dyndns.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-sunxi+bncBDL4X2GMZUKRB7OZ6CLAKGQE7LAYBNI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140119191554.GB32165-9pTldWuhBndy/B6EtB590w@public.gmane.org>
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

On 01/19/2014 08:15 PM, Tejun Heo wrote:
> Hey,
>
> On Sun, Jan 19, 2014 at 07:47:06PM +0100, Hans de Goede wrote:
>> As I see it either doing clks, regulator and sata-core things in a common
>> place makes sense, and then it goes for suspend and resume too, or we
>> opt for always following the complete override model, and which point
>> it becomes more sensible to just do a separate platform driver per
>> ahci implementation.
>
> It makes sense in light of those specific cases, but there are gonna
> be cases where the placement of the callback is slightly wrong and we
> end up with ->XXX_ops_pre() and then ->XXX_ops_post() and so on.
> Please make the whole op overridable and then export the default op
> and use it as library.

If we were to put a generic implementation in ahci_platform.c and export
it for use from overrides to avoid copy and pasting common bits everywhere,
then we still have the ordering problem you are talking about. How do you
envision all of this fitting together, I can imagine ie a
ahci_platform_resume_controller which has the bits of what is currently
ahci_resume stating at:

"if (dev->power.power_state.event == PM_EVENT_SUSPEND) {"

And having ahci_resume in ahci_platform.c still doing the clk and power enabling
before calling into ahci_platform_resume, and drivers overriding the resume method
need to do their own clk + regulator + whatever setup
before calling into ahci_platform_resume_controller ?

Also how do you see overriding the entire op, does that mean that pdata->suspend
will be deprecated (we will need to keep it around for now to avoid breaking
existing drivers using it), and all of:

ahci_probe
ahci_suspend
ahci_resume

Will get exported from ahci_platform.c and drivers needing to override any of them
will provide their own platform_driver struct, pointing either to their overrides,
or for driver methods they don't need to override to the exported function from
ahci_platform.c ?

This would also work nicely for the of_device_id data stuff, since if drivers
have their own platform_driver struct these bits could just go inside the
driver file instead of being in #ifdef CONFIG_FOO in ahci_platform.c

Regards,

Hans
