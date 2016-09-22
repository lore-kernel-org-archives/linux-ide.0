From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) +
 PTR_ERR. Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR.
Date: Thu, 22 Sep 2016 11:49:35 -0400
Message-ID: <20160922154935.GB1892@htj.duckdns.org>
References: <1474487311-3897-1-git-send-email-harman4linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1474487311-3897-1-git-send-email-harman4linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harman Kalra <harman4linux@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Sep 22, 2016 at 01:18:31AM +0530, Harman Kalra wrote:
> Signed-off-by: Harman Kalra <harman4linux@gmail.com>

Fixed up subject and applied to libata/for-4.9.

Thanks.

-- 
tejun
