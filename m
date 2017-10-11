From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: Add support for Cavium's fifth generation SATA
 controller
Date: Wed, 11 Oct 2017 07:09:05 -0700
Message-ID: <20171011140905.GP3301751@devbig577.frc2.facebook.com>
References: <1507700271-12910-1-git-send-email-mohun106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1507700271-12910-1-git-send-email-mohun106@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Radha Mohan Chintakuntla <mohun106@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
List-Id: linux-ide@vger.kernel.org

On Tue, Oct 10, 2017 at 10:37:51PM -0700, Radha Mohan Chintakuntla wrote:
> From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
> 
> This patch adds support for Cavium's fifth generation SATA controller.
> It is an on-chip controller and complies with AHCI 1.3.1. As the
> controller uses 64-bit addresses it cannot use the standard AHCI BAR5
> and so uses BAR4.
> 
> Signed-off-by: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>

Applied to libata/for-4.15.

Thanks.

-- 
tejun
