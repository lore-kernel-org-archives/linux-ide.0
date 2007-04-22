From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 02/13] libata: separate ATA_EHI_DID_RESET into
 DID_SOFTRESET and DID_HARDRESET
Date: Sun, 22 Apr 2007 18:50:30 +0100
Message-ID: <20070422185030.41a342c4@the-village.bc.nu>
References: <11772636651400-git-send-email-htejun@gmail.com>
	<11772636652710-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <11772636652710-git-send-email-htejun@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, mjg59@srcf.ucam.org, rdunlap@xenotime.net, trenn@suse.de, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, 23 Apr 2007 02:41:05 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Separate ATA_EHI_DID_RESET into ATA_EHI_DID_SOFTRESET and
> ATA_EHI_DID_HARDRESET.  ATA_EHI_DID_RESET is redefined as OR of the
> two flags.  This patch doesn't introduce any behavior change.  This
> will be used later to determine whether _SDD is necessary or not.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Acked-by: Alan Cox <alan@redhat.com>

>
