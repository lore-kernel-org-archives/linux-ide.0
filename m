From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2 12/14] ARM: dts: da850: add pinmux settings for the
 SATA controller
Date: Wed, 18 Jan 2017 15:09:59 +0530
Message-ID: <09c88e31-0fd4-15f3-fc0c-25b34b41783b@ti.com>
References: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
 <1484655976-25382-13-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484655976-25382-13-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Kevin Hilman <khilman@kernel.org>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, David Lechner <david@lechnology.com>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Hi Bartosz,

On Tuesday 17 January 2017 05:56 PM, Bartosz Golaszewski wrote:
> Add pinmux sub-nodes for all muxed SATA pins.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Since these are all unused at this time, we should drop adding them
until a time someone really needs these.

Thanks,
Sekhar
