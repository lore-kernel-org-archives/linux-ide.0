From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/3] ARM: shmobile: sata_rcar updates
Date: Wed, 29 Oct 2014 15:58:11 +0100
Message-ID: <CAMuHMdXN-=6budQ=QViG0p3Cfdz1CSVyG6jUC0sRi+iis1nYMA@mail.gmail.com>
References: <1414591131-21771-1-git-send-email-geert+renesas@glider.be>
	<20141029145151.GD25226@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20141029145151.GD25226@htj.dyndns.org>
Sender: linux-sh-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Valentine Barshak <valentine.barshak@cogentembedded.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hi Tejun,

On Wed, Oct 29, 2014 at 3:51 PM, Tejun Heo <tj@kernel.org> wrote:
> On Wed, Oct 29, 2014 at 02:58:48PM +0100, Geert Uytterhoeven wrote:
>> This patch series improves DT bindings documentation and usage for the
>> sata_rcar driver.
>>
>> The first patch was sent before by Valentine Barshak a while ago, but never
>> updated according to the review comments.
>
> I can route these through libata tree once Simon acks them.  Please
> let me know thorugh which tree these should be routed.

I think the first two, tagged "sata_rcar", should go through your tree.
The third one, tagged "ARM: shmobile", should go through Simon's tree.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
