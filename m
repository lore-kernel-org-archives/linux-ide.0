From: Douglas Gilbert <dougg@torque.net>
Subject: Re: SATA Drive Information (vs hdparm -i)?
Date: Fri, 23 Sep 2005 11:14:24 +1000
Message-ID: <433356F0.6090703@torque.net>
References: <7744a2840509221206254d2109@mail.gmail.com>	 <43334AFF.8010901@torque.net>	 <Pine.LNX.4.58.0509221729480.6613@shark.he.net> <7744a28405092218012aa90cd0@mail.gmail.com>
Reply-To: dougg@torque.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <7744a28405092218012aa90cd0@mail.gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
To: Richard Bollinger <rabollinger@gmail.com>
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Richard Bollinger wrote:
> I'm specifically looking for something that will reveal the serial
> number of each SATA drive.

How does:
 sdparm --page=sn /dev/sda
look?

Doug Gilbert
