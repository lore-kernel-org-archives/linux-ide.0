From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: libata pata_pdc2027x success on sparc64
Date: Tue, 18 Jul 2006 22:07:44 +0400
Message-ID: <44BD2370.8090506@ru.mvista.com>
References: <200607172358.k6HNwYhF002052@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932335AbWGRSJG@vger.kernel.org>
In-Reply-To: <200607172358.k6HNwYhF002052@harpo.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, alan@redhat.com
List-Id: linux-ide@vger.kernel.org

Hello.

Mikael Pettersson wrote:

> In contrast, the old IDE pdc202xx_new driver had lots
> of problems with CRC errors causing it to disable DMA.

    Hm, from my experience it usually falls back to UltraDMA/44 and then the 
thing startrt working...

> I wasn't able to manually tune it above udma3 without
> getting more errors. This isn't sparc64-specific: I've
> had similar negative experience with the old IDE Promise
> drivers in a PowerMac.

    This happens because the "old" driver misses the PLL calibration code.
    You may want to try these Albert's patches:

http://marc.theaimsgroup.com/?t=110992452800002&r=1&w=2
http://marc.theaimsgroup.com/?t=110992471500002&r=1&w=2
http://marc.theaimsgroup.com/?t=110992490100002&r=1&w=2
http://marc.theaimsgroup.com/?t=111019238400003&r=1&w=2

    It looks like they were never considered for accepting into the kernel
while they succesfully solve this issue. Maybe Albert could try pushing them 
into -mm tree once more?

WBR, Sergei
