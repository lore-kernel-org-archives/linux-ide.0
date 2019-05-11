From: "U.Mutlu" <um-lNbj7F0cCK5BDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH] drivers: ata: ahci_sunxi: Increased
 SATA/AHCI DMA TX/RX FIFOs
Date: Sat, 11 May 2019 20:12:07 +0200
Message-ID: <5CD71077.1020100@mutluit.com>
References: <20190510192550.17458-1-um@mutluit.com>
 <jwvk1ex6rvb.fsf-monnier+gmane.comp.hardware.netbook.arm.sunxi@gnu.org>
Reply-To: um-lNbj7F0cCK5BDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Return-path: <linux-sunxi+bncBDJNR5GB6YGRB6FA3TTAKGQEVORARWQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <jwvk1ex6rvb.fsf-monnier+gmane.comp.hardware.netbook.arm.sunxi-mXXj517/zsQ@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Stefan Monnier <monnier-CRDzTM1onBSWkKpYnGOUKg@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, u-boot-0aAXYlwwYIKGBzrmiIFOJg@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Stefan Monnier wrote on 05/11/2019 03:37 PM:
>> Increasing the SATA/AHCI DMA TX/RX FIFOs (P0DMACR.TXTS and .RXTS) from
>> default 0x0 each to 0x3 each gives a write performance boost of 120MB/s
>> from lame 36MB/s to 45MB/s previously. Read performance is about 200MB/s
>> [tested on SSD using dd bs=4K count=512K].
>
> Such a simple patch to fix such a long-standing performance problem that
> everyone [ well, apparently not quite everyone ] assumed was a hardware
> limitation...
>
> And yet, April 1st is long gone.
>
> Is it really for real?

Yes, it's indeed real, Stefan; really no April 1st joke.  :-)

As you indicated, this problem of slow SATA write-speed
with these small devices lasts now for more than 5 years.
This patch finally solves the problem.

On my test device (BPI-R1) the optimum blocksize seems to be 12K
as it then gives even 129 MB/s write speed.

Here are some test results with different blocksizes, all giving
a write speed of 125 to 129 MB/s:

time sh -c "dd if=/dev/zero of=test.tmp bs=$bs count=$count conv=fdatasync"


------------ bs=8K / count=256K / 1 ------------------
262144+0 records in
262144+0 records out
2147483648 bytes (2.1 GB) copied, 16.9237 s, 127 MB/s

real	0m16.935s
user	0m0.388s
sys	0m15.777s

------------ bs=8K / count=256K / 2 ------------------
262144+0 records in
262144+0 records out
2147483648 bytes (2.1 GB) copied, 16.9916 s, 126 MB/s

real	0m17.973s
user	0m0.326s
sys	0m16.806s

------------ bs=8K / count=256K / 3 ------------------
262144+0 records in
262144+0 records out
2147483648 bytes (2.1 GB) copied, 17.0085 s, 126 MB/s

real	0m17.993s
user	0m0.442s
sys	0m16.588s

------------ bs=12K / count=171K / 1 ------------------
175104+0 records in
175104+0 records out
2151677952 bytes (2.2 GB) copied, 16.8474 s, 128 MB/s

real	0m16.860s
user	0m0.205s
sys	0m15.705s

------------ bs=12K / count=171K / 2 ------------------
175104+0 records in
175104+0 records out
2151677952 bytes (2.2 GB) copied, 16.6934 s, 129 MB/s

real	0m17.669s
user	0m0.227s
sys	0m16.355s

------------ bs=12K / count=171K / 3 ------------------
175104+0 records in
175104+0 records out
2151677952 bytes (2.2 GB) copied, 16.6684 s, 129 MB/s

real	0m17.654s
user	0m0.388s
sys	0m16.118s

------------ bs=16K / count=128K / 1 ------------------
131072+0 records in
131072+0 records out
2147483648 bytes (2.1 GB) copied, 17.1845 s, 125 MB/s

real	0m17.200s
user	0m0.251s
sys	0m16.060s

------------ bs=16K / count=128K / 2 ------------------
131072+0 records in
131072+0 records out
2147483648 bytes (2.1 GB) copied, 16.9221 s, 127 MB/s

real	0m17.902s
user	0m0.170s
sys	0m16.763s

------------ bs=16K / count=128K / 3 ------------------
131072+0 records in
131072+0 records out
2147483648 bytes (2.1 GB) copied, 16.8845 s, 127 MB/s

real	0m17.868s
user	0m0.167s
sys	0m16.736s
