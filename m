From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RESEND] sata: xgene: add ACPI support for APM X-Gene SATA
 ports
Date: Thu, 19 Mar 2015 14:22:50 -0400
Message-ID: <20150319182250.GC19657@htj.duckdns.org>
References: <1426723435-22378-1-git-send-email-fkan@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426723435-22378-1-git-send-email-fkan@apm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Feng Kan <fkan@apm.com>
Cc: patches@apm.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, Mar 18, 2015 at 05:03:55PM -0700, Feng Kan wrote:
> This adds ACPI support for the APM X-Gene SATA ports. When the system
> boots using ACPI table, the SATA ports are able to configure using the
> values supplied by the ACPI table rather than the DTS.
> 
> Signed-off-by: Feng Kan <fkan@apm.com>
> Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Applied to libata/for-4.1.

Thanks.

-- 
tejun
