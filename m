From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: fix suspend/resume for ATA SEMB devices
Date: Mon, 27 Apr 2009 07:26:49 +0900
Message-ID: <49F4DFA9.6040805@gmail.com>
References: <20090426143836.GA3643@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753054AbZDZW0R@vger.kernel.org>
In-Reply-To: <20090426143836.GA3643@liondog.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: petkovbb@gmail.com, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Borislav Petkov wrote:
> due to a class mismatch in ata_dev_revalidate(). Fix it by adding the
> ATA_DEV_SEMB device class to the check.
> 
> CC: Tejun Heo <htejun@gmail.com>
> CC: Jeff Garzik <jeff@garzik.org>
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
