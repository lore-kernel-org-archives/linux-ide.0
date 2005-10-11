From: Rudolph Pereira <rudolph@faex.net>
Subject: Re: [PATCH 2.6.14-rc3] sis5513.c: enable ATA133 for the SiS965 southbridge
Date: Tue, 11 Oct 2005 20:05:02 +1000
Message-ID: <20051011100502.GB29008@delta.faex.net>
References: <20051005205906.GA4320@farad.aurel32.net> <58cb370e0510060240x2f2e31c3kd0609a06172d86a4@mail.gmail.com> <20051007094135.GA16386@farad.aurel32.net> <4346A41E.3020505@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751443AbVJKKFL@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4346A41E.3020505@verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Wes Newell <w.newell@verizon.net>
Cc: Aurelien Jarno <aurelien@aurel32.net>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Lionel.Bouton@inet6.fr, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Fri, Oct 07, 2005 at 11:36:46AM -0500, Wes Newell wrote:
> It appears to me that this patch will try and apply itself to the real 
> SIS_180 which has the same true_id of 0x180. Can someone tell me what 
> will happen then?
Indeed, I've tried Aurelien's patch and it works fine for me (on an asus
k8s-mx motherboard). Going back over the reasons for the patch that is
in -mm that I submitted, which was a rework of
a patch that Arnaud Patard/Uwe Koziolek sent to linux-ide, it seems that the
thinking was that complex probing and/or configuration was required for
this chipset. I don't have any specs to work from, and am not the expert
in any case, but it would seem that this is not necessary, and
just doing a standard detect of the southbridge id is fine.

Unless anyone has stronger evidence/experience, it would seem that the
simplest/cleanest solution is an update to SiSHostChipInfo[], as in Aurelien's
patch.
