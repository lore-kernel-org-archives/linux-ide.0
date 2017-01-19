From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 09/13] sata: ahci: export ahci_do_hardreset() locally
Date: Thu, 19 Jan 2017 04:52:29 -0800
Message-ID: <20170119125229.GA16438@mtj.duckdns.org>
References: <1484745601-4769-1-git-send-email-bgolaszewski@baylibre.com>
 <1484745601-4769-10-git-send-email-bgolaszewski@baylibre.com>
 <20170118182826.GA1451@mtj.duckdns.org>
 <CAMpxmJULuF3cB7+Vy_qeWkTjooHvx8yk70w59Q=XNd0aAREcuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMpxmJULuF3cB7+Vy_qeWkTjooHvx8yk70w59Q=XNd0aAREcuw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, arm-soc <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On Thu, Jan 19, 2017 at 11:55:24AM +0100, Bartosz Golaszewski wrote:
> 2017-01-18 19:28 GMT+01:00 Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> > Hello, Bartosz.
> >
> > On Wed, Jan 18, 2017 at 02:19:57PM +0100, Bartosz Golaszewski wrote:
> >> We need a way to retrieve the information about the online state of
> >> the link in the ahci-da850 driver.
> >>
> >> Create a new function: ahci_do_hardreset() which is called from
> >> ahci_hardreset() for backwards compatibility, but has an additional
> >> argument: 'online' - which can be used to check if the link is online
> >> after this function returns.
> >
> > Please just add @online to ahci_hardreset() and update the callers.
> > Other than that, the sata changes look good to me.
> >
> 
> Are you sure? There are 23 places in drivers/ata/ where the .hardreset
> callback is assigned. I'd prefer not to change the drivers I can't
> test. Besides all other **reset callbacks take three arguments -
> should we really only change one of them for a single driver's needs?

Ah, didn't realize this was the callback, sorry.  What you did is
perfect.  Please disregard my comment.

Thanks.

-- 
tejun
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
