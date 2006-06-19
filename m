From: "Ilia Sotnikov" <hostcc@gmail.com>
Subject: Status of SAS ability to attach SATA devices
Date: Mon, 19 Jun 2006 20:47:07 +0300
Message-ID: <6ac07bf90606191047o131ec37eq6e1bcaf6205ea8ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-scsi-owner@vger.kernel.org
To: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com, James.Bottomley@steeleye.com
List-Id: linux-ide@vger.kernel.org

Hardware: IBM 206m, AIC 9405 SAS/SATA controller, 2 SATA drives.

Having read several threads about SAS ability to attach SATA devices
(what's needed in my case), I found that this is work-in-progress.

Also during the investigation I've found that there are exist several
GIT trees with different SAS / AIC94xx versions: maintained by James
Bottomley, Jeff Garzik and Luben Tuikov.

I've tried all three of above mentioned versions - PHYs are discovered
correctly (as far as I can tell) but no disk devices are registered.
According to comments in sources that's predictable.

Questions are:
- what tree is recommended to work on;
- how could I help (if could) to improve the situation.

Thanks in advance,
-- 
 Ilia Sotnikov
