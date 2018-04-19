From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 02/61] ata: simplify getting .drvdata
Date: Thu, 19 Apr 2018 19:22:33 +0300
Message-ID: <c486565a-d3f3-2ce0-eca2-3aa60a6c99b2@cogentembedded.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180419140641.27926-3-wsa+renesas@sang-engineering.com>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello!

On 04/19/2018 05:05 PM, Wolfram Sang wrote:

> We should get drvdata from struct device directly. Going via

  Note that the name of the field in the 'struct device' is driver_data,
not drvdata. Otherwise the patch looks good.

> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
[...]

MBR, Sergei
