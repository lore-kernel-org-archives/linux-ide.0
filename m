From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH v3] ata: Fix DVD not dectected at some Haswell platforms
Date: Wed, 03 Apr 2013 19:44:09 -0400
Message-ID: <515CBEC9.1050707@pobox.com>
References: <1362584945-10202-1-git-send-email-youquan.song@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1362584945-10202-1-git-send-email-youquan.song@intel.com>
Sender: stable-owner@vger.kernel.org
To: Youquan Song <youquan.song@intel.com>
Cc: htejun@gmail.com, ming.lei@canonical.com, sshtylyov@mvista.com, lpechacek@suse.cz, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, seth.heasley@intel.com, jlee@suse.com, james.d.ralston@intel.com, stable@vger.kernel.org, Youquan Song <youquan.song@linux.intel.com>
List-Id: linux-ide@vger.kernel.org

On 03/06/2013 10:49 AM, Youquan Song wrote:
> There is a quirk patch 5e5a4f5d5a08c9c504fe956391ac3dae2c66556d
> "ata_piix: make DVD Drive recognisable on systems with Intel Sandybridge
>   chipsets(v2)" fixing the 4 ports IDE controller 32bit PIO mode.
>
> We've hit a problem with DVD not recognized on Haswell Desktop platform which
> includes Lynx Point 2-port SATA controller.
>
> This quirk patch disables 32bit PIO on this controller in IDE mode.
>
> v2: Change spelling error in statememnt pointed by Sergei Shtylyov.
> v3: Change comment statememnt and spliting line over 80 characters pointed by
>      Libor Pechacek and also rebase the patch against 3.8-rc7 kernel.
>
> Tested-by: Lee, Chun-Yi <jlee@suse.com>
> Signed-off-by: Youquan Song <youquan.song@intel.com>
> Cc: stable@vger.kernel.org
> ---
>   drivers/ata/ata_piix.c |   14 +++++++++++++-
>   1 files changed, 13 insertions(+), 1 deletions(-)

applied
