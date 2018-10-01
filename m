From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 0/4] AHCI support for BCM63138
Date: Mon, 1 Oct 2018 16:39:46 -0600
Message-ID: <1f741f17-0374-f519-504b-adee93340d68@kernel.dk>
References: <20181001173302.25398-1-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181001173302.25398-1-f.fainelli@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On 10/1/18 11:32 AM, Florian Fainelli wrote:
> Hi Jens,
> 
> This is a resend of the previous series posted here:
> 
> https://lkml.org/lkml/2018/9/20/1060
> 
> With a few minor changes:
> 
> - rebased against your for-4.20/libata branch
> - added Rob's Reviewed-by to patch
> - fixed the use of the reset controller API

Thanks, applied for 4.20.

-- 
Jens Axboe
