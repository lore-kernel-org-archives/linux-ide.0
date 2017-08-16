From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] PNP: ide: constify pnp_device_id
Date: Wed, 16 Aug 2017 11:10:41 -0700 (PDT)
Message-ID: <20170816.111041.525900390371271349.davem@davemloft.net>
References: <60c34272432b3411cd5d55728c62481e133f32a6.1502859040.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <60c34272432b3411cd5d55728c62481e133f32a6.1502859040.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: arvind.yadav.cs@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Wed, 16 Aug 2017 10:24:32 +0530

> pnp_device_id are not supposed to change at runtime. All functions
> working with pnp_device_id provided by <linux/pnp.h> work with
> const pnp_device_id. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied.
