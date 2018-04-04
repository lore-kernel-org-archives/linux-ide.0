From: Tejun Heo <tj@kernel.org>
Subject: Re: [GIT PULL] libata changes for v4.17-rc1
Date: Wed, 4 Apr 2018 10:06:17 -0700
Message-ID: <20180404170617.GB3126663@devbig577.frc2.facebook.com>
References: <20180403143257.GN388343@devbig577.frc2.facebook.com>
 <CA+55aFyU+MnzfTfkvCgNJp+QZJdyfYrJmdzy0Z_PbxOcBTfByA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFyU+MnzfTfkvCgNJp+QZJdyfYrJmdzy0Z_PbxOcBTfByA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: IDE-ML <linux-ide@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Tue, Apr 03, 2018 at 05:59:04PM -0700, Linus Torvalds wrote:
> People hotplug ATA _controllers_?   :-O
> 
> As opposed to just the disks a'la eSATA?

Heh, yeah, it's surprising.  IIUC, it's people trying pcie hotplug (I
don't know whether they try physically) on SAS controllers on fancy
machines.

Thanks.

-- 
tejun
