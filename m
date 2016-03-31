From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH v2 1/3] libahci: save port map for forced port map
Date: Thu, 31 Mar 2016 13:24:37 -0500
Message-ID: <20160331182437.GC8252@hector.attlocal.net>
References: <1459445500-9071-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1459445500-9071-2-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459445500-9071-2-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jmaggard10@gmail.com
List-Id: linux-ide@vger.kernel.org

On Thu, Mar 31, 2016 at 06:31:38PM +0100, Srinivas Kandagatla wrote:
> In usecases where force_port_map is used saved_port_map is never set,
> resulting in not programming the PORTS_IMPL register as part of initial
> config. This patch fixes this by setting it to port_map even in case
> where force_port_map is used, making it more inline with other parts of
> the code.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Reviewed-by: Andy Gross <andy.gross@linaro.org>
