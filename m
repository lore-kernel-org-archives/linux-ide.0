From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: 2.6.22 libata spindown
Date: Sat, 2 Jun 2007 00:23:58 -0300
Message-ID: <20070602032358.GA8815@khazad-dum.debian.net>
References: <4ac8254d0706011314g5468f02m3cf5a5281bd30018@mail.gmail.com> <4660841D.5050003@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759383AbXFBDYT@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4660841D.5050003@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tuncer Ayaz <tuncer.ayaz@gmail.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Fri, 01 Jun 2007, Jeff Garzik wrote:
> IIRC, Debian was the one OS that really did need a shutdown utility 
> update, as the message says :)

Actually, editing /etc/init.d/halt is enough.  Find the hddown="-h" and
change it to hddown="".

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
