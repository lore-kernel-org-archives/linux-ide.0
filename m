From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 0/3] ata: ahci-platform: add reset control support
 except for existing drivers
Date: Wed, 22 Aug 2018 08:27:17 -0700
Message-ID: <20180822152717.GU3978217@devbig004.ftw2.facebook.com>
References: <1534939983-16264-1-git-send-email-hayashi.kunihiko@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1534939983-16264-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, Aug 22, 2018 at 09:13:00PM +0900, Kunihiko Hayashi wrote:
> Add support to get and control a list of resets for the device, and
> add the flag indicating whether to use the reset. Existing SoC-dependent
> drivers set 0 to this flag.

Applied to libata/for-4.19.

Thanks.

-- 
tejun
