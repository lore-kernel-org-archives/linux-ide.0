From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v6 05/14] ARM: davinci: da850: add con_id for the SATA
 clock
Date: Fri, 27 Jan 2017 15:28:55 +0530
Message-ID: <135d0aac-11a3-e71a-4f39-82bdb2afea39@ti.com>
References: <1485190856-4711-1-git-send-email-bgolaszewski@baylibre.com>
 <1485190856-4711-6-git-send-email-bgolaszewski@baylibre.com>
 <93a3bbb3-2d9f-bc38-c7b4-5eb3325d985d@ti.com>
 <645778dd-6727-abd0-3dd9-a7e0d5aa4983@ti.com>
 <CAMpxmJXq-XZBhO3j=bHpfU2QjJ+6kiYcozS7-pVu3W4juNTVBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAMpxmJXq-XZBhO3j=bHpfU2QjJ+6kiYcozS7-pVu3W4juNTVBw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, linux-devicetree <devicetree@vger.kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Grygorii Strashko <grygorii.strashko@ti.com>, David Lechner <david@lechnology.com>, Kevin Hilman <khilman@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Russell King <linux@armlinux.org.uk>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Patrick Titiano <ptitiano@baylibre.com>, Tejun Heo <tj@kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-ide@vger.kernel.org

On Friday 27 January 2017 03:25 PM, Bartosz Golaszewski wrote:
> Hi Sekhar,
> 
> I'll wait with sending v7 until we get an ack from Rob for the
> ahci-da850 bindings, so that we don't fall to the bottom of the review
> queue again.

Yes, makes sense.

Regards,
Sekhar
