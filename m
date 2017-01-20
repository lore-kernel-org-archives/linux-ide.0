From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 00/14] ARM: da850-lcdk: add SATA support
Date: Fri, 20 Jan 2017 10:00:36 -0500
Message-ID: <20170120150036.GA6164@mtj.duckdns.org>
References: <1484911325-23425-1-git-send-email-bgolaszewski@baylibre.com>
 <20170120132843.GA31487@mtj.duckdns.org>
 <86bcbb3c-87e4-3508-f4a6-26529f39d374@ti.com>
 <CAMpxmJUPh9MZKwG6k6p_mo6niXNNT02JCDgXi4DPRH2Fk3yxng@mail.gmail.com>
 <f9055043-507f-74de-b2b8-9eb0eae5dad6@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f9055043-507f-74de-b2b8-9eb0eae5dad6-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, arm-soc <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Hello, Sekhar.

On Fri, Jan 20, 2017 at 07:52:35PM +0530, Sekhar Nori wrote:
> Tejun, I am open to queuing the driver changes through ARM-SoC. I guess
> with that there is little chance that SATA will be broken on linux-next
> for a longish period of time.

Yeah, I'd prefer the patchset staying together.  That's how it was
developed and tested.  Don't wanna break it apart unnecessarily.  The
chance for conflicts is low and even when that happens dealing with
them is pretty easy.  Please feel free to add my acked-by and route
the patches through ARM-SoC.

Thanks.

-- 
tejun
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
