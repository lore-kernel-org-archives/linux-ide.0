From: Richard Bollinger <rabollinger@gmail.com>
Subject: Re: SATA Drive Information (vs hdparm -i)?
Date: Thu, 22 Sep 2005 21:18:10 -0400
Message-ID: <7744a28405092218186e0958e1@mail.gmail.com>
References: <7744a2840509221206254d2109@mail.gmail.com>
	 <43334AFF.8010901@torque.net>
	 <Pine.LNX.4.58.0509221729480.6613@shark.he.net>
	 <7744a28405092218012aa90cd0@mail.gmail.com>
	 <433356F0.6090703@torque.net>
Reply-To: Richard Bollinger <rabollinger@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <433356F0.6090703@torque.net>
Content-Disposition: inline
Sender: linux-scsi-owner@vger.kernel.org
To: linux-scsi@vger.kernel.org
Cc: linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Bingo:
# sdparm --page=sn /dev/sda
    /dev/sda: ATA       WDC WD3200JD-00K  08.0
Unit serial number VPD page:
       WD-WMAMR1316505

I'll have to look at the drives in the morning to be sure, but it
looks good to me.

Thanks!

On 9/22/05, Douglas Gilbert <dougg@torque.net> wrote:
> Richard Bollinger wrote:
> > I'm specifically looking for something that will reveal the serial
> > number of each SATA drive.
>
> How does:
>  sdparm --page=sn /dev/sda
> look?
>
> Doug Gilbert
>
