From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/3] ahci: st: st_configure_oob must be called after IP
 is clocked.
Date: Tue, 31 Mar 2015 11:59:51 -0400
Message-ID: <20150331155951.GG9974@htj.duckdns.org>
References: <1427787309-1601-1-git-send-email-peter.griffin@linaro.org>
 <1427787309-1601-4-git-send-email-peter.griffin@linaro.org>
 <20150331152958.GF9974@htj.duckdns.org>
 <20150331153627.GA8200@griffinp-ThinkPad-X1-Carbon-2nd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150331153627.GA8200@griffinp-ThinkPad-X1-Carbon-2nd>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, lee.jones@linaro.org, devicetree@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, Mar 31, 2015 at 04:36:27PM +0100, Peter Griffin wrote:
> This patch (and also the DT documentation change) can go via your tree. Maxime
> will take the stih407 DT patch.

Hmmm... The first patch doesn't apply to libata/for-4.1?

Thanks.

-- 
tejun
