From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH 1/3] libahci: save port map for forced port map
Date: Thu, 31 Mar 2016 12:43:28 -0400
Message-ID: <20160331164328.GA24661@htj.duckdns.org>
References: <1459257075-21393-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1459257075-21393-2-git-send-email-srinivas.kandagatla@linaro.org>
 <20160330185706.GQ7822@mtj.duckdns.org>
 <56FD4923.3090209@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56FD4923.3090209@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>, Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jmaggard10@gmail.com
List-Id: linux-ide@vger.kernel.org

Hello,

On Thu, Mar 31, 2016 at 04:58:27PM +0100, Srinivas Kandagatla wrote:
> Yes, that is the intention, I guess, This was done exactly in case where the
> port number was fabricated too.
> 
> Without this I could not get the sata working on my board with forced port
> map option.

I see.  Looks good to me then.  Can you please respin the patches with
the updates for the review points in the second patch?  I'll apply
them to libata/for-3.6-fixes.

Thanks.

-- 
tejun
