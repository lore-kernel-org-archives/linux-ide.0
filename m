From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] ata: pata_oldpiix: Add missing device ID for
 INTEL_82371AB
Date: Mon, 10 Dec 2018 17:52:35 +0300
Message-ID: <9aab3632-4647-cb66-f720-8f6742bc9b4e@cogentembedded.com>
References: <1544449564-16557-1-git-send-email-clabbe@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544449564-16557-1-git-send-email-clabbe@baylibre.com>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
To: Corentin Labbe <clabbe@baylibre.com>, axboe@kernel.dk, b.zolnierkie@samsung.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello!

On 12/10/2018 04:46 PM, Corentin Labbe wrote:

> When playing with a virtual SPARC machine with qemu, I found that the
> IDE emulated device was not probing with the ata/pata_oldpiix driver.

   Correctly, it should probe with ata_piix,

> But with the old ide/piix, it was probed.> 
> This is due to this PCI devid was not migrated from the old ide/piix.

   It wasn't on purpose -- the IDE driver supports the original PIIX
incorrectly.

> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

   NAK.

MBR, Sergei
