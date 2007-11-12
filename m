From: Tejun Heo <htejun@gmail.com>
Subject: Re: [2.6 patch] libata: remove unused functions
Date: Tue, 13 Nov 2007 00:11:42 +0900
Message-ID: <47386D2E.5090202@gmail.com>
References: <20071111112956.GM21669@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751768AbXKLPMQ@vger.kernel.org>
In-Reply-To: <20071111112956.GM21669@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Adrian Bunk wrote:
> This patch removes the following obsolete functions:
> - libata-core.c: __sata_phy_reset()
> - libata-core.c: sata_phy_reset()
> - libata-eh.c: ata_qc_timeout()
> - libata-eh.c: ata_eng_timeout()
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

Queued in #tj-upstream-fixes which will be merged into 2.6.24.

Thanks.

-- 
tejun
