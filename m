From: Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH 0/2] ata: libahci: devslp fixes
Date: Thu, 7 Mar 2019 12:27:35 -0800
Message-ID: <CAMHSBOVOK15nchZRFGTZUu8KSbBiK3SFzgW1amLjXb1iv_gJ5g@mail.gmail.com>
References: <20180702190154.6864-1-srinivas.pandruvada@linux.intel.com>
 <9712316ab62bef25953c523bce02e260a9ea40fe.camel@linux.intel.com>
 <20180730152256.GF1206094@devbig004.ftw2.facebook.com> <bf4b860c-6f82-4a3f-8b81-5f5c93f4389e@redhat.com>
 <20180730173345.GI1206094@devbig004.ftw2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180730173345.GI1206094@devbig004.ftw2.facebook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, alan.cox@intel.com, IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, rajatja@chromium.org
List-Id: linux-ide@vger.kernel.org

Srinivas,

I am looking at problem on a laptop machine that suspends to S01x, but
link_management is set to max_performance, because the machine is
connected to a charger.
Given DVLSP must be set before the laptop suspends ["""One of the
requirement for modern x86 system to enter lowest power mode  (SLP_S0)
is SATA IP block to be off."""], the machine never reaches S01x.
Does it make sense to change the target_lpm_policy at suspend
(ata_port_suspend()) to min_power and bring it back to the original
value on resume?

Gwendal.


On Mon, Jul 30, 2018 at 10:33 AM Tejun Heo <tj@kernel.org> wrote:
>
> On Mon, Jul 30, 2018 at 05:26:45PM +0200, Hans de Goede wrote:
> > Hi,
> >
> > On 30-07-18 17:22, Tejun Heo wrote:
> > >On Mon, Jul 30, 2018 at 08:15:47AM -0700, Srinivas Pandruvada wrote:
> > >>Hi Tejan,
> > >>
> > >>On Mon, 2018-07-02 at 12:01 -0700, Srinivas Pandruvada wrote:
> > >>>Some minor fixes to be able to correctly set devslp register
> > >>>to optimize power.
> > >>>
> > >>>Srinivas Pandruvada (2):
> > >>>   ata: libahci: Correct setting of DEVSLP register
> > >>>   ata: libahci: Allow reconfigure of DEVSLP register
> > >>>
> > >>Are you applying this series?
> > >
> > >I was waiting for Hans's reviews.  Hans, what do you think?
> >
> > Ah I missed that this was another series. With the caveat that
> > I do not really know that much about devslp, both patches
> > seem sensible to me, so both are:
> >
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> Applied 1-2 to libata/for-4.19.
>
> Thanks.
>
> --
> tejun
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
