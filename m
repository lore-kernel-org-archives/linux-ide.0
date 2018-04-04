From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] libata changes for v4.17-rc1
Date: Tue, 3 Apr 2018 17:59:04 -0700
Message-ID: <CA+55aFyU+MnzfTfkvCgNJp+QZJdyfYrJmdzy0Z_PbxOcBTfByA@mail.gmail.com>
References: <20180403143257.GN388343@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180403143257.GN388343@devbig577.frc2.facebook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE-ML <linux-ide@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Tue, Apr 3, 2018 at 7:32 AM, Tejun Heo <tj@kernel.org> wrote:
>
> The biggest change is refcnting fix for
> ata_host - the bug is recent and can only be triggered on controller
> hotplug, so very few are hitting it.

People hotplug ATA _controllers_?   :-O

As opposed to just the disks a'la eSATA?

I knew of pcmcia ata cards ("People still do pcmcia?"), but didn't
realize it really happened elsewhere.

Regardless, pulled.

              Linus
