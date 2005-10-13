From: Daniel Drake <dsd@gentoo.org>
Subject: Re: [PATCH] via82cxxx IDE: Remove /proc/via entry
Date: Thu, 13 Oct 2005 23:52:36 +0100
Message-ID: <434EE534.6010500@gentoo.org>
References: <43146CC3.4010005@gentoo.org>  <58cb370e05083008121f2eb783@mail.gmail.com>  <43179CC9.8090608@gentoo.org>  <58cb370e050927062049be32f8@mail.gmail.com>  <433B16BD.7040409@gentoo.org>  <Pine.LNX.4.63.0509290042160.21130@alpha.polcom.net> <58cb370e0509290027404f5224@mail.gmail.com> <Pine.LNX.4.63.0510091707220.21130@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964879AbVJMWwe@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0510091707220.21130@alpha.polcom.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, posting@blx4.net, vsu@altlinux.ru
List-Id: linux-ide@vger.kernel.org

Hi,

Grzegorz Kulewski wrote:
>>> As a user of this controller, I think that if it is not then this patch
>>> should be changed to export it or should be dropped. The data from that
>>> file is really helpfull in debugging problems (for example related to 
>>> bad
>>> cables or breaking disks/cdroms).

Per Bart's suggestion, I've created a user-space app which shows identical 
data (and doesn't even rely on the via82cxxx IDE driver).

http://www.reactivated.net/software/viaideinfo/

So, I think we should be clear to drop /proc/ide/via now.

Daniel
