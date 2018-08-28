From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] ata: ahci: Convert to using %pOFn instead of
 device_node.name
Date: Tue, 28 Aug 2018 08:44:02 -0600
Message-ID: <111e6704-49fc-621a-036e-e659ebe08519@kernel.dk>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-9-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180828015252.28511-9-robh@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 8/27/18 7:52 PM, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.

Applied for 4.20, thanks.

-- 
Jens Axboe
