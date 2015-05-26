From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata:sata_nv - Change 1 to true for bool type variable.
Date: Tue, 26 May 2015 14:47:58 -0400
Message-ID: <20150526184758.GK7099@htj.duckdns.org>
References: <1432584505-5274-1-git-send-email-shailendra.capricorn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432584505-5274-1-git-send-email-shailendra.capricorn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shailendra Verma <shailendra.capricorn@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, May 26, 2015 at 01:38:25AM +0530, Shailendra Verma wrote:
> The variable swncq_enabled is bool type. Hence initialize it
> with true instead of 1.
> 
> Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>

Applied to libata/for-4.2.

-- 
tejun
