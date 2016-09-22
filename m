From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: Replace BUG() with BUG_ON().
Date: Thu, 22 Sep 2016 11:47:22 -0400
Message-ID: <20160922154722.GA1892@htj.duckdns.org>
References: <1474487988-4207-1-git-send-email-harman4linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1474487988-4207-1-git-send-email-harman4linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harman Kalra <harman4linux@gmail.com>
Cc: b.zolnierkie@samsung.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Sep 22, 2016 at 01:29:48AM +0530, Harman Kalra wrote:
> Replace BUG() with BUG_ON().
> Caught by coccinelle.
> 
> Signed-off-by: Harman Kalra <harman4linux@gmail.com>

Applied libata/for-4.9.

Thanks.

-- 
tejun
