From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC v3 04/13] ahci-platform: Undo pdata->resume on
 resume failure
Date: Sun, 19 Jan 2014 19:40:21 +0100
Message-ID: <52DC1C15.1030107@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com> <1390088935-7193-5-git-send-email-hdegoede@redhat.com> <20140119112737.GC11123@htj.dyndns.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBHFY6CLAKGQE5NIXV4I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140119112737.GC11123-Gd/HAXX7CRxy/B6EtB590w@public.gmane.org>
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

On 01/19/2014 12:27 PM, Tejun Heo wrote:
> Hello,
>
> On Sun, Jan 19, 2014 at 12:48:46AM +0100, Hans de Goede wrote:
>> When the ahci_resume fails the error handling code tries to undo all changes
>> made, but it was not undoing the results of pdata->resume.
>>
>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> ---
>>   drivers/ata/ahci_platform.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
>> index dc1ef73..41720cb 100644
>> --- a/drivers/ata/ahci_platform.c
>> +++ b/drivers/ata/ahci_platform.c
>> @@ -307,7 +307,7 @@ static int ahci_resume(struct device *dev)
>>   	if (dev->power.power_state.event == PM_EVENT_SUSPEND) {
>>   		rc = ahci_reset_controller(host);
>>   		if (rc)
>> -			goto disable_unprepare_clk;
>> +			goto pdata_suspend;
>>
>>   		ahci_init_controller(host);
>>   	}
>> @@ -316,6 +316,9 @@ static int ahci_resume(struct device *dev)
>>
>>   	return 0;
>>
>> +pdata_suspend:
>> +	if (pdata && pdata->suspend)
>> +		pdata->suspend(dev);
>>   disable_unprepare_clk:
>>   	if (!IS_ERR(hpriv->clk))
>>   		clk_disable_unprepare(hpriv->clk);
>
> Hmmmm... resume isn't an operation you can revert without side-effect
> when the whole system is waking up from sleep.  e.g. think about what
> should happen the driver is removed and loaded again - it should be
> able to reinitialized the device, which is unlikely to work if the
> device is suspended at the platform level.  If resume fails, the right
> state to be in is "failed with as much as resumed" instead of
> "suspended".

That sounds like your advocating for just returning from resume on the
first error without undoing any of the previous steps, have I gotten that
right?

That sounds as sensible as any other approach on resume errors
(there are IMHO no good answers), if that is what you mean, shall I do a
patch in the next versions of my patch-set doing that ?

Regards,

Hans
