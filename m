From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 3/5] ata: add Broadcom AHCI SATA3 driver for STB chips
Date: Thu, 21 May 2015 18:20:59 -0400
Message-ID: <20150521222059.GM4914@htj.duckdns.org>
References: <1431473303-18873-1-git-send-email-computersforpeace@gmail.com>
 <1431473303-18873-4-git-send-email-computersforpeace@gmail.com>
 <CAOMZO5DtNa2-bgdGmiiJM4JZ7MHz2THSsNMwT=9oWO1ThNu2KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5DtNa2-bgdGmiiJM4JZ7MHz2THSsNMwT=9oWO1ThNu2KA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Brian Norris <computersforpeace@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kevin Cernekee <cernekee@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com, Gregory Fong <gregory.0xf0@gmail.com>, Kumar Gala <galak@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-ide@vger.kernel.org

On Thu, May 21, 2015 at 07:16:07PM -0300, Fabio Estevam wrote:
> On Tue, May 12, 2015 at 8:28 PM, Brian Norris
> <computersforpeace@gmail.com> wrote:
> 
> > +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ahci");
> > +       ahci = devm_ioremap_resource(&pdev->dev, res);
> > +       if (IS_ERR(ahci))
> > +               return 0;
> 
> You should propagate 'return PTR_ERR(ahci)' instead.

Brian, can you please update the patch?

Thanks.

-- 
tejun
