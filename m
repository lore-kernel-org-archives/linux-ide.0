From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 8/8] drivers: misc: use module_platform_driver_probe()
Date: Fri, 15 Mar 2013 11:13:51 -0700
Message-ID: <20130315181351.GA16747@kroah.com>
References: <1363280978-24051-1-git-send-email-fabio.porcedda@gmail.com>
 <1363280978-24051-9-git-send-email-fabio.porcedda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1363280978-24051-9-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, linux-ide@vger.kernel.org, linux-input@vger.kernel.org, linux-fbdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-ide@vger.kernel.org

On Thu, Mar 14, 2013 at 06:09:38PM +0100, Fabio Porcedda wrote:
> This patch converts the drivers to use the
> module_platform_driver_probe() macro which makes the code smaller and
> a bit simpler.

Someone else beat you to this fix for these files, sorry.

greg k-h
