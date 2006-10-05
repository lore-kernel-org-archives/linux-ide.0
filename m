From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: 2.6.19-rc1: known regressions
Date: Thu, 05 Oct 2006 17:16:40 +1000
Message-ID: <1160032600.7086.4.camel@nigel.suspend2.net>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
	 <20061005042816.GD16812@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20061005042816.GD16812@stusta.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Klaus Knopper <knopper@knopper.net>, Andi Kleen <ak@suse.de>, Luca Tettamanti <kronos.it@gmail.com>, gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, discuss@x86-64.org, Thierry Vignaud <tvignaud@mandriva.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, "Michael S. Tsirkin" <mst@mellanox.co.il>, len.brown@intel.com, linux-acpi@vger.kernel.org, Olaf Hering <olaf@aepfle.de>, Jens Axboe <axboe@suse.de>
List-Id: linux-ide@vger.kernel.org

Hi.

On Thu, 2006-10-05 at 06:28 +0200, Adrian Bunk wrote:
> Contrary to popular belief, there are people who test -rc kernels
> and report bugs.
> 
> And there are even people who test -git kernels.

Slightly off topic, but let me report a "metoo" as far as testing -git
goes (you can even find a suspend2-against-current-git tree on
kernel.org now!), and some positive progress: for the first time in
months, I'm reliably suspending and resuming my amd64 based laptop. I
don't have an exact cause, but would guess at Andi's multitude of
patches and/or any cpufreq fixes that might have slid in there too. It's
been really strange writing software that others can use reliably, and
not being able to reliably use it yourself! Kudos to all the authors of
suspend/resume bug fixes that have gone in!

Nigel

