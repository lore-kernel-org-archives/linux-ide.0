From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/3] ARM: shmobile: sata_rcar updates
Date: Thu, 30 Oct 2014 09:00:02 +0900
Message-ID: <20141030000002.GE4599@verge.net.au>
References: <1414591131-21771-1-git-send-email-geert+renesas@glider.be>
 <20141029145151.GD25226@htj.dyndns.org>
 <CAMuHMdXN-=6budQ=QViG0p3Cfdz1CSVyG6jUC0sRi+iis1nYMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXN-=6budQ=QViG0p3Cfdz1CSVyG6jUC0sRi+iis1nYMA@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tejun Heo <tj@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Valentine Barshak <valentine.barshak@cogentembedded.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Wed, Oct 29, 2014 at 03:58:11PM +0100, Geert Uytterhoeven wrote:
> Hi Tejun,
> 
> On Wed, Oct 29, 2014 at 3:51 PM, Tejun Heo <tj@kernel.org> wrote:
> > On Wed, Oct 29, 2014 at 02:58:48PM +0100, Geert Uytterhoeven wrote:
> >> This patch series improves DT bindings documentation and usage for the
> >> sata_rcar driver.
> >>
> >> The first patch was sent before by Valentine Barshak a while ago, but never
> >> updated according to the review comments.
> >
> > I can route these through libata tree once Simon acks them.  Please
> > let me know thorugh which tree these should be routed.
> 
> I think the first two, tagged "sata_rcar", should go through your tree.
> The third one, tagged "ARM: shmobile", should go through Simon's tree.

Yes, I think so too.

For the first two patches:

Acked-by: Simon Horman <horms+renesas@verge.net.au>

I'll pick up the last patch myself.

