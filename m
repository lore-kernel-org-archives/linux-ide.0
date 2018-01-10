From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/3] ata: Allow having a port recovery callback
Date: Wed, 10 Jan 2018 19:02:15 +0300
Message-ID: <ae1eaa6b-6121-21f1-1ba9-551f9ce3920b@cogentembedded.com>
References: <1515539097-26742-1-git-send-email-f.fainelli@gmail.com>
 <1515539097-26742-2-git-send-email-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515539097-26742-2-git-send-email-f.fainelli@gmail.com>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>, bcm-kernel-feedback-list@broadcom.com
Cc: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Heiko Stuebner <heiko@sntech.de>, Srinath Mannam <srinath.mannam@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, Dan Carpenter <dan.carpenter@oracle.com>, "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hello!

On 01/10/2018 02:04 AM, Florian Fainelli wrote:

> Some AHCI controllers may need to recovery from a failure to identify a drive,

    Recover.

> such as the Broadcom AHCI controller, make that possible at both the
> libata-core.c and AHCI controller level such that we can provide such an error
> recovery callback.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
[...]

MBR, Sergei
