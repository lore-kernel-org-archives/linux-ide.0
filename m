From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] ata: macio: Use of_node_name_eq for node name comparisons
Date: Fri, 8 Feb 2019 06:45:57 -0700
Message-ID: <4bca6415-36d1-f7f6-7208-2e4b1c3ea778@kernel.dk>
References: <20181205195050.4759-4-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205195050.4759-4-robh@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 12/5/18 12:50 PM, Rob Herring wrote:
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.

Applied, thanks.

-- 
Jens Axboe
