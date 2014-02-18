From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/3] ahci: st: Add support for ST's SATA IP
Date: Tue, 18 Feb 2014 18:36:45 -0500
Message-ID: <20140218233645.GP31892@mtj.dyndns.org>
References: <1392641818-23419-1-git-send-email-lee.jones@linaro.org>
 <1392641818-23419-3-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1392641818-23419-3-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alexandre.torgue@st.com, linux-ide@vger.kernel.org, hdegoede@redhat.com
List-Id: linux-ide@vger.kernel.org

On Mon, Feb 17, 2014 at 12:56:58PM +0000, Lee Jones wrote:
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-ide@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Please consider basing it on top of Hans' refactored ahci_platform.

 http://www.spinics.net/lists/linux-ide/msg47628.html

Thanks.

-- 
tejun
