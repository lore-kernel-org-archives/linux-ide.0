From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC v3 04/13] ahci-platform: Undo pdata->resume on
 resume failure
Date: Sun, 19 Jan 2014 20:34:51 +0100
Message-ID: <52DC28DB.7070804@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com> <1390088935-7193-5-git-send-email-hdegoede@redhat.com> <20140119112737.GC11123@htj.dyndns.org> <52DC1C15.1030107@redhat.com> <20140119191349.GA32165@mtj.dyndns.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBYOR6CLAKGQEFKZYSQI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140119191349.GA32165-9pTldWuhBndy/B6EtB590w@public.gmane.org>
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

On 01/19/2014 08:13 PM, Tejun Heo wrote:
> Hello,
>
> On Sun, Jan 19, 2014 at 07:40:21PM +0100, Hans de Goede wrote:
>> That sounds like your advocating for just returning from resume on the
>> first error without undoing any of the previous steps, have I gotten that
>> right?
>
> Yeah, or just ignore reset failure and proceed.

That seems like a bad idea IMHO, if reset failed something is seriously
amiss and just continuing as nothing happened seems unhelpful.

>> That sounds as sensible as any other approach on resume errors
>> (there are IMHO no good answers), if that is what you mean, shall I do a
>
> Suspending back is the wrong answer tho.
>
>> patch in the next versions of my patch-set doing that ?
>
> Isn't just dropping this patch enough tho?

Well the current error handling still re-disables the clks on resume failure,
if you want to proceed with resume as far as possible, rather then return to
a suspended state it seems sensible to just leave the clocks on as well.

Also disabling the clocks on resume failure, followed by a rmmod will cause
a WARN_ON to trigger in the clock-framework when ahci_host_stop tries to
disable the clks for a second time.

Regards,

Hans
